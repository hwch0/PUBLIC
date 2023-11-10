package com.kr.pub.dto;

import java.security.Timestamp;
import java.time.LocalDateTime;

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
  private String seatNo;
  private String userId;
  private LocalDateTime time = LocalDateTime.now();
}
