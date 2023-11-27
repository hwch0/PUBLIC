package com.kr.pub.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.compress.utils.FileNameUtils;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kr.pub.dao.ItemDAO;
import com.kr.pub.dto.ExcelReadDTO;
import com.kr.pub.dto.ItemDTO;
import com.kr.pub.util.ExcelFileType;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;

@Service
public class ExcelService {

	@Autowired
	ItemDAO itemDAO;
	
	//엑셀 업로드
	public static List<Map<String, String>> read(ExcelReadDTO excelReadOption){
		if(excelReadOption != null) {
			Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
			FormulaEvaluator evaluator = wb.getCreationHelper().createFormulaEvaluator();
			List<Map<String, String>> result = new ArrayList<>();
			
			for(int sheetIndex = 0; sheetIndex < wb.getNumberOfSheets(); sheetIndex++) {
				Sheet sheet = wb.getSheetAt(sheetIndex);
				int numOfRows = sheet.getLastRowNum() + 1;
				
				if(numOfRows <= 1) {
					Map<String, String> map = new HashMap<>();
					map.put("errorMessage", "numOfRows가 1이하 입니다.");
					result.add(map);
					return result;
				}
				
				for(int rowIndex = excelReadOption.getStartRow() -1; rowIndex < numOfRows; rowIndex++) {
					Row row = sheet.getRow(rowIndex);
					if(row != null && sheet.getRow(rowIndex).getCell(2) != null) {
						Map<String,String> map = new HashMap<>();
						
						for(int colIndex = 0; colIndex < 9; colIndex++) {
							Cell cell = row.getCell(colIndex);
							String columnHeader = String.valueOf((char)('A' + colIndex));
							
							if(cell != null) {
								switch (cell.getCellType()) {
									case NUMERIC:
										if(DateUtil.isCellDateFormatted(cell)) {
											//날자 형식 "YYYY-MM-dd"변환
											SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
											map.put(columnHeader, formatter.format(cell.getDateCellValue()));
										}else {
											//숫자 형식 소수점 이하 정수 변환
											double numericValue = cell.getNumericCellValue();
											map.put(columnHeader, String.valueOf((numericValue == (int) numericValue) ? (int) numericValue : numericValue));
										}
										break;
									case STRING:
										map.put(columnHeader, cell.getStringCellValue());
										break;
									case FORMULA:
										CellType cellType = evaluator.evaluateFormulaCell(cell);
										switch (cellType) {
											case NUMERIC:
												if(DateUtil.isCellDateFormatted(cell)) {
													SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
													map.put(columnHeader, formatter.format(cell.getDateCellValue()));
												}else {
													double numericValue = cell.getNumericCellValue();
													map.put(columnHeader, String.valueOf((numericValue == (int) numericValue) ? (int) numericValue : numericValue));
												}
												break;
											case STRING:
												try {
													double value = Double.parseDouble(cell.getStringCellValue());
													map.put("column", String.valueOf((value == (int) value) ? (int) value : value));
												} catch(NumberFormatException e) {
													map.put("column", cell.getStringCellValue());
												}
												break;
											default:
												break;
										}
										break;
								}
							}
						}
						System.out.println("값: " + map);
						result.add(map);
					} else {
						break;
					}
				}
			}
			return result;
		}
		return null;
	}
	
	public Map<String, String> uploadExcel(MultipartHttpServletRequest req){
		Map<String, String> result = new HashMap<>();
		
		try {
			MultipartFile excelFile = req.getFile("excelFile");
			
			if(excelFile == null || excelFile.isEmpty()) {
				result.put("code", "2");
				result.put("msg", "파일이 없습니다.");
			} else {
				String originalFileName = excelFile.getOriginalFilename().replaceAll("[^a-zA-Z0-9.-]", "");
				
				String fileExt = FileNameUtils.getExtension(originalFileName);
				
				if(fileExt == null || fileExt.equals("")) {
					result.put("code", "1");
					result.put("msg", "허용되지 않는 확장자명 입니다.");
				} else {
					File uploadDir = new File("C:\\upload\\Excel");
					uploadDir.mkdirs();
					
					File destFile = new File(uploadDir, originalFileName.substring(0, originalFileName.lastIndexOf('.')) + "." + fileExt);
					excelFile.transferTo(destFile);
					
					result.put("code", "3");
					result.put("msg", "업로드 성공");
					
					readExcel(destFile);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("code", "4");
			result.put("msg", "에러 발생");
		}
		
		return result;
	}
	
	public void readExcel(File file)  throws Exception {
		ExcelReadDTO excelReadOption = new ExcelReadDTO();
		excelReadOption.setFilePath(file.getAbsolutePath());
		excelReadOption.setOutputColumns("A", "B", "C", "D", "E", "F", "G", "H","I");
		excelReadOption.setStartRow(2);
		
		List<Map<String, String>> excelData =read(excelReadOption);
		
		System.out.println("Read Excel Data: " + excelData);
		
		saveDB(excelData);
	}
	
	private void saveDB(List<Map<String, String>> excelData) throws Exception{
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		for(Map<String, String> dataMap : excelData) {
			ItemDTO itemDTO = new ItemDTO();
			
			System.out.println("DataMap: " + dataMap);
			System.out.println("value of A: " +dataMap.get("A"));
			
			itemDTO.setItemId(dataMap.get("A"));
			
		}
	}
	
	//업로드용 excel
	public void excelDownloads(HttpServletResponse res, List<String>headerNames, String fileName) throws Exception{
		// excel sheet 생성
		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("Sheet1"); //엑셀 sheet 이름
		sheet.setDefaultColumnWidth(28); //디폴트 너비 설정
		
		//헤더 생성
		XSSFFont headerXSSFFont = (XSSFFont) workbook.createFont();
		headerXSSFFont.setColor(new XSSFColor(new byte[]{(byte) 255, (byte) 255, (byte) 255}));
        
		 //header cell style
        XSSFCellStyle headerXssfCellStyle = (XSSFCellStyle) workbook.createCellStyle();

        // 테두리 설정
        headerXssfCellStyle.setBorderLeft(BorderStyle.THIN);
        headerXssfCellStyle.setBorderRight(BorderStyle.THIN);
        headerXssfCellStyle.setBorderTop(BorderStyle.THIN);
        headerXssfCellStyle.setBorderBottom(BorderStyle.THIN);

        // 배경 설정
        headerXssfCellStyle.setFillForegroundColor(new XSSFColor(new byte[]{(byte) 34, (byte) 37, (byte) 41}));
        headerXssfCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerXssfCellStyle.setFont(headerXSSFFont);
        
        //body cell style
        XSSFCellStyle bodyXssfCellStyle = (XSSFCellStyle) workbook.createCellStyle();

        // 테두리 설정
        bodyXssfCellStyle.setBorderLeft(BorderStyle.THIN);
        bodyXssfCellStyle.setBorderRight(BorderStyle.THIN);
        bodyXssfCellStyle.setBorderTop(BorderStyle.THIN);
        bodyXssfCellStyle.setBorderBottom(BorderStyle.THIN);
        
        Row headerRow = sheet.createRow(0);
        
        for (int i = 0; i < headerNames.size(); i++) {
            Cell headerCell = headerRow.createCell(i);
            headerCell.setCellValue(headerNames.get(i));
            headerCell.setCellStyle(headerXssfCellStyle);
        }
        
        res.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        res.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");
        ServletOutputStream servletOutputStream = res.getOutputStream();

        workbook.write(servletOutputStream);
        workbook.close();
        servletOutputStream.flush();
        servletOutputStream.close();         
	}
	
	//목록 다운로드
	public void excelDownload(HttpServletResponse res, String sheetName, List<String>headerNames, List<String> headerLabels,
								List<Map<String, Object>> dataList, String fileName) throws Exception{		
		//excel sheet 생성
		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet(sheetName);
		sheet.setDefaultColumnWidth(28);
		
		//헤더 생성
		XSSFFont headerXSSFFont = (XSSFFont) workbook.createFont();
		headerXSSFFont.setColor(new XSSFColor(new byte[]{(byte) 255, (byte) 255, (byte) 255}));
        
		 //header cell style
        XSSFCellStyle headerXssfCellStyle = (XSSFCellStyle) workbook.createCellStyle();

        // 테두리 설정
        headerXssfCellStyle.setBorderLeft(BorderStyle.THIN);
        headerXssfCellStyle.setBorderRight(BorderStyle.THIN);
        headerXssfCellStyle.setBorderTop(BorderStyle.THIN);
        headerXssfCellStyle.setBorderBottom(BorderStyle.THIN);

        // 배경 설정
        headerXssfCellStyle.setFillForegroundColor(new XSSFColor(new byte[]{(byte) 34, (byte) 37, (byte) 41}));
        headerXssfCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerXssfCellStyle.setFont(headerXSSFFont);
        
        //body cell style
        XSSFCellStyle bodyXssfCellStyle = (XSSFCellStyle) workbook.createCellStyle();

        // 테두리 설정
        bodyXssfCellStyle.setBorderLeft(BorderStyle.THIN);
        bodyXssfCellStyle.setBorderRight(BorderStyle.THIN);
        bodyXssfCellStyle.setBorderTop(BorderStyle.THIN);
        bodyXssfCellStyle.setBorderBottom(BorderStyle.THIN);
        
        Row headerRow = sheet.createRow(0);
        
        for (int i = 0; i < headerLabels.size(); i++) {
            Cell headerCell = headerRow.createCell(i);
            headerCell.setCellValue(headerLabels.get(i));
            headerCell.setCellStyle(headerXssfCellStyle);
        }
        
        //데이터 생성
        for(int i = 0; i < dataList.size(); i++) {
        	Row dataRow = sheet.createRow(i + 1);
        	Map<String, Object> rowDataMap = dataList.get(i);
        	
        	int j = 0;
        	for(String headerName : headerNames) {
        		Cell dataCell = dataRow.createCell(j++);
        		Object value = rowDataMap.get(headerName);
        		dataCell.setCellValue(value == null ? "" : value.toString());
        		dataCell.setCellStyle(bodyXssfCellStyle);
        	}
        }
        
        res.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        res.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");
        ServletOutputStream servletOutputStream = res.getOutputStream();

        workbook.write(servletOutputStream);
        workbook.close();
        servletOutputStream.flush();
        servletOutputStream.close();  
	}
	
}