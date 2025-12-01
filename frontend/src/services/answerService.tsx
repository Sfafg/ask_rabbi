import { Api } from "./api";

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
