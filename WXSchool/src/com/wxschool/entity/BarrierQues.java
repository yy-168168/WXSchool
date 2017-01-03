package com.wxschool.entity;

public class BarrierQues {

	private int quesId;
	private int barrierId;
	private String title;
	private String choiceA;
	private String choiceB;
	private String choiceC;
	private String choiceD;
	private String rightChoice;
	private int status;

	public int getQuesId() {
		return quesId;
	}

	public void setQuesId(int quesId) {
		this.quesId = quesId;
	}

	public int getBarrierId() {
		return barrierId;
	}

	public void setBarrierId(int barrierId) {
		this.barrierId = barrierId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getChoiceA() {
		return choiceA;
	}

	public void setChoiceA(String choiceA) {
		this.choiceA = choiceA;
	}

	public String getChoiceB() {
		return choiceB;
	}

	public void setChoiceB(String choiceB) {
		this.choiceB = choiceB;
	}

	public String getChoiceC() {
		return choiceC;
	}

	public void setChoiceC(String choiceC) {
		this.choiceC = choiceC;
	}

	public String getChoiceD() {
		return choiceD;
	}

	public void setChoiceD(String choiceD) {
		this.choiceD = choiceD;
	}

	public String getRightChoice() {
		return rightChoice;
	}

	public void setRightChoice(String rightChoice) {
		this.rightChoice = rightChoice;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
