package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.WDEBoardFile;
import com.icia.web.model.WDEBoard;

@Repository("eBoardDao")
public interface WDEBoardDao 
{
	//게시물 리스트
	public List<WDEBoard> eBoardList(WDEBoard wdEBoard);
	
	//게시물 총 수
	public long eBoardListCount(WDEBoard wdEBoard);
	
	//게시물 조회
	public WDEBoard eBoardSelect(long bSeq);
	
	//게시물 첨부파일 조회
	public WDEBoardFile eBoardFileSelect(long eBSeq);
	
	//게시물 조회수 증가
	public long eBoardReadCntPlus(long bSeq);
	
	//게시물 등록
	public int eBoardInsert(WDEBoard wdEBoard);
	
	//게시물 파일 첨부
	public int eBoardFileInsert(WDEBoardFile wdEBoardFile);
	
	//게시물 파일 DB첨부
	public int eBoardFileUpdate(WDEBoard wdEBoard);
	
	//게시물 수정
	public int eBoardUpdate(WDEBoard wdEBoard);
	
	//게시물 삭제
	public int eBoardDelete(long bSeq);
	
	//게시물(eBoard) 첨부파일 삭제
	public int eBoardFileDelete(long bSeq);
	
	//게시물(eventFile) 첨부파일 삭제
	public int eventFileDelete(String fileName);
	
	//게시물 첨부파일 이미지 네임
	public String maxImgName();
	
	//게시물 첨부파일 이미지 네임 조회
	public String searchImgName(long eBSeq);
	
}
