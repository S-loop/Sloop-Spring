package kr.co.sloop.postForum.repository;

import kr.co.sloop.postForum.domain.PostForumDTO;

import java.util.HashMap;
import java.util.List;

public interface PostForumRepository {
    public int insertPostForum(PostForumDTO postForumDTO);

    // post 테이블에 글 등록
    int insertPost(PostForumDTO postForumDTO);


    int selectMemberIdxByMemberEmail(String memberEmail);

    List<PostForumDTO> list(HashMap<String, Integer> map);

    PostForumDTO findByPostIdx(int postIdx);

    int update(PostForumDTO postForumDTO);

    int delete(int postIdx);

    void updatePostForumHits(int postIdx);
}