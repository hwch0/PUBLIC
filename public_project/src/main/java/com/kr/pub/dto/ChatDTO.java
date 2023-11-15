package com.kr.pub.dto;

import java.time.ZoneId;
import java.time.ZonedDateTime;

import com.kr.pub.util.TimeApi;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatDTO {
  private String type;
  private String sender;
  private String receiver;
  private String message;
  private int seatNo;
  private String userId;
  private String recvUserId;
  private java.sql.Timestamp time = TimeApi.encodingTime(ZonedDateTime.now(ZoneId.of("Asia/Seoul")));
}
