import { Api } from "./api";
import { jwt } from "./authService";

const api = new Api();

export interface User {
	id: number;
	username: string;
	email: string;
}

export interface Answer {
	id: number;
	body: string;
	user: User;
}

export function getAnswersToQuestion(questionId: number) {
	return api.get<Array<Answer>>(`/answers/question/${questionId}`, {});
}

export function getAnswersToAnswer(answerId: number) {
	return api.get<Array<Answer>>(`/answers/answer/${answerId}`, {});
}

export function postAnswerToQuestion(questionid: number, body: string) {
	return api.post(
		`/answers`,
		{
			"Content-Type": "application/json",
			Authorization: `Bearer ${jwt?.token}`,
		},
		JSON.stringify({ questionid, body }),
	);
}

export function postAnswerToAnswer(answerid: number, body: string) {
	return api.post(
		`/answers`,
		{
			"Content-Type": "application/json",
			Authorization: `Bearer ${jwt?.token}`,
		},
		JSON.stringify({ answerid, body }),
	);
}

export function updateAnswer(answerid: number, body: string) {
	return api.put(
		`/answers/${answerid}`,
		{
			"Content-Type": "application/json",
			Authorization: `Bearer ${jwt?.token}`,
		},
		JSON.stringify({ body }),
	);
}
