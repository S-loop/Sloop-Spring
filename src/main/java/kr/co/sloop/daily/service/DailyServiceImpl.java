package kr.co.sloop.daily.service;

import kr.co.sloop.daily.domain.DailyDTO;
import kr.co.sloop.daily.domain.PageDTO;
import kr.co.sloop.daily.repository.DailyRepositoryImpl;
import kr.co.sloop.daily.service.impl.DailyService;
import kr.co.sloop.post.repository.PostRepositoryImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class DailyServiceImpl implements DailyService {
    private final DailyRepositoryImpl dailyRepository;
    private final PostRepositoryImpl postRepository;

    // 공부인증 전체리스트 불러오기
    @Override
    public List<DailyDTO> getAllDailyList() {
        return dailyRepository.getAllDailyList();
    }

    // 공부인증 게시글 작성
    @Override
    public boolean dailyWrite(DailyDTO dailyDTO) {
        int result = 0;

/*        // 임의, 수정해야함
        dailyDTO.setMemberIdx(1);
        dailyDTO.setBoardIdx(1);*/

        // memberEmail로 memberIdx 알아내기
        Integer memberIdx = postRepository.selectMemberIdxByMemberEmail(dailyDTO.getMemberEmail());
        if(memberIdx == null)   return false; // memberEmail에 해당하는 memberIdx가 존재하지 않는다.
        dailyDTO.setMemberIdx(memberIdx.intValue());

        // post 에 작성
        result = dailyRepository.insertPost(dailyDTO);
        if(result != 1) return false;

        // daily 글 작성
        result = dailyRepository.dailyWrite(dailyDTO);
        if (result != 1) return false;

        return true;
    }


    //제목으로 글 검색
    @Override
    public List<DailyDTO> getDailyListByTitle(String postDailyTitle) {
        List<DailyDTO> dailyListByTitle = dailyRepository.getDailyListByTitle(postDailyTitle);
        return dailyListByTitle;
    }

    //상세보기
    @Override
    public DailyDTO findByPostIdx(int postIdx) {
        DailyDTO dailyByPostIdx = dailyRepository.findByPostIdx(postIdx);
        return dailyByPostIdx;
    }

    //수정하기
    @Override
    public int update(DailyDTO dailyDTO) {
        return  dailyRepository.update(dailyDTO);
    }

    //삭제
    @Override
    public void delete(int postIdx) {
        dailyRepository.delete(postIdx);
    }

    //조회수
    @Override
    public void updateViewCnt(int postIdx) {
        dailyRepository.updateViewCnt(postIdx);
    }

    //페이징
    int pageLimit = 5; //한 페이지당 보여지는 글 개수 : 5
    int blockLimit = 5; //하단에 보여지는 페이지 번호 개수

    @Override
    public List<DailyDTO> pageList(int page) {

        int pagingStart = (page-1) * pageLimit;
        Map<String, Integer> pagingParams = new HashMap<>();

        pagingParams.put("start",pagingStart);
        pagingParams.put("limit",pageLimit);
        List<DailyDTO> pagingList = dailyRepository.pageList(pagingParams);

        return pagingList;
    }

    //페이징-PageDTO
    @Override
    public PageDTO pagingParam(int page) {
        // 전체 글 개수 조회
        int boardCount = dailyRepository.boardCount();
        // 전체 페이지 개수 계산
        int maxPage = (int) (Math.ceil((double) boardCount / pageLimit));
        // 시작 페이지 값 계산
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        // 끝 페이지 값 계산

        int endPage = startPage + blockLimit - 1;

        if (endPage > maxPage) {
            endPage = maxPage;
        }

        PageDTO pageDTO = new PageDTO();

        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);

        return pageDTO;

    }

}