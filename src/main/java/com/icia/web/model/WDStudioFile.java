/**스튜디오보현**/
package com.icia.web.model;

import java.io.Serializable;

public class WDStudioFile  implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long sSeq;
    private String sCode;
    private long sFileSeq;
    private String sfileName;
    private String sFileOrgName;
    private String sFileExt;
    private long sFileSize;
    private String regDate;
    
    public WDStudioFile()
    {
    	sSeq = 0;
    	sCode = "";
    	sFileSeq = 0;
    	sfileName = "";
    	sFileOrgName = "";
    	sFileExt = "";
    	sFileSize = 0;
    	regDate = "";
    }

	public long getsSeq() {
		return sSeq;
	}

	public void setsSeq(long sSeq) {
		this.sSeq = sSeq;
	}

	public String getsCode() {
		return sCode;
	}

	public void setsCode(String sCode) {
		this.sCode = sCode;
	}

	public long getsFileSeq() {
		return sFileSeq;
	}

	public void setsFileSeq(long sFileSeq) {
		this.sFileSeq = sFileSeq;
	}

	public String getSfileName() {
		return sfileName;
	}

	public void setSfileName(String sfileName) {
		this.sfileName = sfileName;
	}

	public String getsFileOrgName() {
		return sFileOrgName;
	}

	public void setsFileOrgName(String sFileOrgName) {
		this.sFileOrgName = sFileOrgName;
	}

	public String getsFileExt() {
		return sFileExt;
	}

	public void setsFileExt(String sFileExt) {
		this.sFileExt = sFileExt;
	}

	public long getsFileSize() {
		return sFileSize;
	}

	public void setsFileSize(long sFileSize) {
		this.sFileSize = sFileSize;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
    
     
}
