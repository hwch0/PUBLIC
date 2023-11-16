package com.kr.pub.service;

import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;

@Service
public class ExcelService {

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