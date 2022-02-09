package com.icia.web.model;

import java.io.Serializable;

public class WDReview implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long RSeq;
	private String rezNo;
	private String UserId;
	private String UNickName;
	private String WDate;
	private String RTitle;
	private String RContent;
	private long RReadCnt;
	private String RegDate;
	private double RScore;
	private String rezStatus;
	private String reviewStatus;
	

	private WDReviewFile reviewFile;
	
    private String searchValue;      //검색값
    private String searchType;		//검색조건
    
	private long startRow;
	private long endRow;
	
	private String today;	//오늘 날짜 체크
	
	private String whCode;
	private String hCode;
	private String sCode;
	private String dcCode;
	private String dNo;
	private String mCode;
	
	private String hName;
	private String sName;
	private String dName;
	private String mName;
	
	public WDReview() {
		  RSeq = 0;
		  rezNo = "";
		  UserId = "";
		  UNickName = "";
		  WDate = "";
		  RTitle = "";
		  RContent = "";
		  RReadCnt = 0;
		  RegDate = "";
		  RScore = 0;
		  rezStatus = "N";
		  reviewFile = null;
		  searchValue = "";
		startRow = 0;
		endRow = 0;
		today = "";
		reviewStatus = "";
		
		 whCode = "없음";
		 hCode = "없음";
		 sCode = "없음";
		 dcCode = "없음";
		 dNo = "없음";
		 mCode = "없음";
		
		 hName = "없음";
		 sName = "없음";
		 dName = "없음";
		 mName = "없음";
	}
		
	public String getWhCode() {
		return whCode;
	}


	public void setWhCode(String whCode) {
		this.whCode = whCode;
	}


	public String gethCode() {
		return hCode;
	}


	public void sethCode(String hCode) {
		this.hCode = hCode;
	}


	public String getsCode() {
		return sCode;
	}


	public void setsCode(String sCode) {
		this.sCode = sCode;
	}


	public String getDcCode() {
		return dcCode;
	}


	public void setDcCode(String dcCode) {
		this.dcCode = dcCode;
	}


	public String getdNo() {
		return dNo;
	}


	public void setdNo(String dNo) {
		this.dNo = dNo;
	}


	public String getmCode() {
		return mCode;
	}


	public void setmCode(String mCode) {
		this.mCode = mCode;
	}


	public String gethName() {
		return hName;
	}
	
	public void sethName(String hName) {
		this.hName = hName;
	}

	public String getsName() {
		return sName;
	}

	public void setsName(String sName) {
		this.sName = sName;
	}

	public String getdName() {
		return dName;
	}

	public void setdName(String dName) {
		this.dName = dName;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}



	public String getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}

	public String getToday() {
		return today;
	}


	public void setToday(String today) {
		this.today = today;
	}


	public long getStartRow() {
		return startRow;
	}


	public void setStartRow(long startRow) {
		this.startRow = startRow;
	}


	public long getEndRow() {
		return endRow;
	}


	public void setEndRow(long endRow) {
		this.endRow = endRow;
	}


	public String getRezNo() {
		return rezNo;
	}


	public void setRezNo(String rezNo) {
		this.rezNo = rezNo;
	}


	public String getRezStatus() {
		return rezStatus;
	}


	public void setRezStatus(String rezStatus) {
		this.rezStatus = rezStatus;
	}

	public String getSearchValue() {
		return searchValue;
	}


	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}


	public WDReviewFile getReviewFile() {
		return reviewFile;
	}


	public void setReviewFile(WDReviewFile reviewFile) {
		this.reviewFile = reviewFile;
	}


	public long getRSeq() {
		return RSeq;
	}

	public void setRSeq(long rSeq) {
		RSeq = rSeq;
	}

	public String getUserId() {
		return UserId;
	}

	public void setUserId(String userId) {
		UserId = userId;
	}

	public String getUNickName() {
		return UNickName;
	}

	public void setUNickName(String uNickName) {
		UNickName = uNickName;
	}

	public String getWDate() {
		return WDate;
	}

	public void setWDate(String wDate) {
		WDate = wDate;
	}

	public String getRTitle() {
		return RTitle;
	}

	public void setRTitle(String rTitle) {
		RTitle = rTitle;
	}

	public String getRContent() {
		return RContent;
	}

	public void setRContent(String rContent) {
		RContent = rContent;
	}

	public long getRReadCnt() {
		return RReadCnt;
	}

	public void setRReadCnt(long rReadCnt) {
		RReadCnt = rReadCnt;
	}

	public String getRegDate() {
		return RegDate;
	}

	public void setRegDate(String regDate) {
		RegDate = regDate;
	}

	public double getRScore() {
		return RScore;
	}

	public void setRScore(double rScore) {
		RScore = rScore;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	
	

}
