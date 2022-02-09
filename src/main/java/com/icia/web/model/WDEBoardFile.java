package com.icia.web.model;

import java.io.Serializable;

public class WDEBoardFile implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long bSeq;				//게시물 번호 
	private short FileSeq;			//게시물 번호별 파일 번호
	private String FileOrgName;		//원본 파일명
	private String FileName;		//저장될 파일명
	private String FileExt;			//파일 확장자 명
	private long FileSize;			//파일 크기(byte단위)
	private String regDate;			//등록일
	
	public WDEBoardFile() 
	{
		bSeq = 0;
		FileSeq = 0;
		FileOrgName = "";
		FileName = "";
		FileExt = "";
		FileSize = 0;
		regDate = "";
	}

	public long getbSeq() {
		return bSeq;
	}

	public short getFileSeq() {
		return FileSeq;
	}

	public String getFileOrgName() {
		return FileOrgName;
	}

	public String getFileName() {
		return FileName;
	}

	public String getFileExt() {
		return FileExt;
	}

	public long getFileSize() {
		return FileSize;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setbSeq(long bSeq) {
		this.bSeq = bSeq;
	}

	public void setFileSeq(short fileSeq) {
		FileSeq = fileSeq;
	}

	public void setFileOrgName(String fileOrgName) {
		FileOrgName = fileOrgName;
	}

	public void setFileName(String fileName) {
		FileName = fileName;
	}

	public void setFileExt(String fileExt) {
		FileExt = fileExt;
	}

	public void setFileSize(long fileSize) {
		FileSize = fileSize;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	
}
