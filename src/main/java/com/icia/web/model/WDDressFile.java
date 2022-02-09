package com.icia.web.model;

import java.io.Serializable;

public class WDDressFile implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String dcCode;
	private long dFileSeq;
	private String dFileName;
	private String dFileOrgName;
	private String dFileExt;
	private long dFileSize;
	private String regDate;
	
	public WDDressFile() {
		 dcCode = "";
		 dFileSeq = 0;
		 dFileName = "";
		 dFileOrgName = "";
		 dFileExt = "";
		 dFileSize = 0;
		 regDate = "";
	}

	public String getdcCode() {
		return dcCode;
	}

	public void setdcCode(String dcCode) {
		this.dcCode = dcCode;
	}

	public long getdFileSeq() {
		return dFileSeq;
	}

	public void setdFileSeq(long dFileSeq) {
		this.dFileSeq = dFileSeq;
	}

	public String getdFileName() {
		return dFileName;
	}

	public void setdFileName(String dFileName) {
		this.dFileName = dFileName;
	}

	public String getdFileOrgName() {
		return dFileOrgName;
	}

	public void setdFileOrgName(String dFileOrgName) {
		this.dFileOrgName = dFileOrgName;
	}

	public String getdFileExt() {
		return dFileExt;
	}

	public void setdFileExt(String dFileExt) {
		this.dFileExt = dFileExt;
	}

	public long getdFileSize() {
		return dFileSize;
	}

	public void setdFileSize(long dFileSize) {
		this.dFileSize = dFileSize;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	

}
