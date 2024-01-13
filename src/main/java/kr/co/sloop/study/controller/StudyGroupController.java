package kr.co.sloop.study.controller;

import kr.co.sloop.study.domain.StudyGroupDTO;
import kr.co.sloop.study.service.StudyGroupService;
import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.html.Option;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@Controller
@RequestMapping("/study")
@Log4j2
public class StudyGroupController {

	@Autowired // 의존성 주입
	private StudyGroupService studyGroupService;

	/*
	 * 메인페이지에 보여줄 모든 스터디 그룹에 대한 정보 요청 처리
	 */
	@RequestMapping // 메서드 수준의 @RequestMapping -> method 속성 기본값=GET
	public String requestStudyGroupList(Model model){ // 웹 요청 처리할 메서드
		List<StudyGroupDTO> list = studyGroupService.getAllStudyGroupList();
		model.addAttribute("studyGroupList", list); // model 객체에 view에 전달할 정보 담는다.
		return "study/list"; // view
	}

	/*
	 * 스터디 그룹 개설 : 화면 처리
	 */
	@GetMapping("/add")
	public String requestAddStudyGroupForm(@ModelAttribute("StudyGroupDTO") StudyGroupDTO studyGroupDTO, Model model){

		model.addAttribute("categoryGradeList1", null);
		return "study/addStudyGroup";
	}

	/*
	 * 스터디 그룹 개설 : DB insert
	 */
	@PostMapping("/add")
	@ResponseBody
	public String submitAddStudyGroupForm(@ModelAttribute("StudyGroupDTO") StudyGroupDTO studyGroupDTO, HttpSession session){
		studyGroupDTO.setStudyGroupCode(getRandomStudyGroupCode());
		String memberIdx = (String)session.getAttribute("loginMemberIdx");
		log.info("memberIdx=====>"+memberIdx);
		boolean result = studyGroupService.insertNewStudyGroup(studyGroupDTO, memberIdx); // insert into studyGroup + make 4 Boards + grant ROLE_STUDY_LEADER
		if(result == true)
			return "redirect:/study/"+studyGroupDTO.getStudyGroupCode(); // 스터디 그룹의 메인 페이지
		else
			return "study/list";
	}

	/**
	 * 스터디 그룹 Code로 세부정보 요청 처리
	 * URI : /study/{studyGroupCode}
	 */
	@GetMapping("/{studyGroupCode}")
	public String requestStudyGroup(@PathVariable("studyGroupCode") String studyGroupCode, Model model){
		StudyGroupDTO studyGroupDTO = studyGroupService.getStudyGroupByGroupCode(studyGroupCode);
		List<HashMap<String,String>> groupBoardIdxs = studyGroupService.getBoardIdxsByGroupCode(studyGroupDTO.getStudyGroupIdx());
		model.addAttribute("studyGroup", studyGroupDTO);
		model.addAttribute("groupBoardIdxs", groupBoardIdxs);
		return "study/home";
	}

	/**
	 * 스터디 그룹 관리 페이지: 스터디 설정 호출
	 * URI : /study/{studyGroupCode}/info
	 */
	@GetMapping("/{studyGroupCode}/manage/info")
	public String requestStudyGroupInfo(@PathVariable("studyGroupCode") String studyGroupCode, Model model){
		StudyGroupDTO studyGroupDTO = studyGroupService.getStudyGroupByGroupCode(studyGroupCode);
		model.addAttribute("StudyGroup", studyGroupDTO);
		return "study/infoForm";
	}

	/**
	 * 스터디 설정 수정
	 * URI : /study/{studyGroupCode}/info
	 */
	@PostMapping("/{studyGroupCode}/manage/info")
	public String submitUpdateStudyGroupForm(@PathVariable("studyGroupCode") String studyGroupCode,
											 @ModelAttribute("StudyGroup") StudyGroupDTO studyGroupDTO,
											 RedirectAttributes RA){
		int result = studyGroupService.updateStudyGroup(studyGroupDTO);
		if(result == 1) {
			RA.addFlashAttribute("resultMessage","수정을 완료했습니다."); // redirect로 넘길경우 model로 attribute를 넘기면 자동으로 쿼리로 변경되어 넘어감
			return "redirect:/study/" + studyGroupDTO.getStudyGroupCode() + "/manage/info"; // 그룹 정보 수정 뒤에 동일한 페이지로 redirect
		}
		else {
			log.info("스터디 그룹 정보 수정 오류");
			return "redirect:/study/" + studyGroupDTO.getStudyGroupCode() + "/manage/info"; // alert 띄울 수 있도록 경고 전송
		}
	}

	/**
	 * 스터디 그룹 폐쇄: 스터디 설정 호출
	 * URI : /study/{studyGroupCode}/delete
	 */
	@GetMapping("/{studyGroupCode}/delete")
	public String requestDeleteStudyGroup(@PathVariable("studyGroupCode") String studyGroupCode, Model model){
		// 스터디 리더일 때만 폐쇄 가능하도록 로그인한 세션과 비교할 수 있는 코드 필요
		int result = studyGroupService.deleteGroupByGroupCode(studyGroupCode);
		if(result > 0)
			return "redirect:/study"; // 나중에 동작 확인한 뒤에 redirect URI 변경 예정
		else
			return "study/"+studyGroupCode+"/infoForm";
	}





	// 카테고리 ajax 불러오기
//	@RequestMapping(value = "/{option1}", produces = "application/json; charset=UTF-8", method= RequestMethod.GET)
//	@ResponseBody
//	public void get_option1(HttpServletResponse res, @PathVariable String option1) throws IOException {
//
//		List<Option> options = studyGroupService.findOption1(option1);
//		List<String> optionList = new ArrayList();
//
//		for (int i = 0; i < options.size(); i++) {
//			optionList.add(options.get(i).getOption1());
//		}
//
//		JSONArray jsonArray = new JSONArray();
//		for (int i = 0; i < optionList.size(); i++) {
//			jsonArray.put(optionList.get(i));
//		}
//
//		PrintWriter pw = res.getWriter();
//		pw.print(jsonArray.toString());
//		pw.flush();
//		pw.close();
//	}
	public static JSONObject convertMapToJson(HashMap<String,Object> map){
        
        JSONObject json = new JSONObject();
        for(Map.Entry<String, Object>entry:map.entrySet()){
            String key = entry.getKey();
            Object value = entry.getValue();
            json.put(key, value);
        }
        return json;
    }
	


	/*
	 * 스터디 그룹 코드 난수 생성 메서드
	 *  usage: 스터디 그룹 개설시 사용
	 */
	public String getRandomStudyGroupCode(){
		Random rnd =new Random();
		StringBuffer buf =new StringBuffer();
		for (int i=0;i<10;i++) { // rnd.nextBoolean() 는 랜덤으로 true, false 를 리턴. true일 시 랜덤 한 소문자를, false 일 시 랜덤 한 숫자를 StringBuffer 에 append 한다.

			if(rnd.nextBoolean()){
				buf.append((char)((int)(rnd.nextInt(26))+65));
			}else{
				buf.append((rnd.nextInt(10)));
			}
		}
		System.out.println("buf = " + buf);
		return buf.toString();
	}
	
}
