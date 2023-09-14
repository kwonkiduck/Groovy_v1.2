package kr.co.groovy.memo;

import java.util.List;

import kr.co.groovy.vo.MemoVO;

public interface MemoMapper {
	
	public List<MemoVO> getMemo();
	
	public MemoVO getOneMemo(int memoSn);
	
	public int inputMemo(MemoVO memoVO);
	
	public int modifyMemo(MemoVO memoVO);
	
	public int deleteMemo(int memoSn);
}
