import { Api } from "./api";
import { jwt } from "./authService";

const api = new Api();

export interface User {
	id: number;
	username: string;
	email: string;
}

export interface Question {
	id: number;
	user: User;
	body: string;
}

export function getQuestions(offset: number, limit: number) {
	return api.get<Array<Question>>(
		`/questions?offset=${offset}&limit=${limit}`,
		{},
	);
}

export function searchQuestions(phrase: string, offset: number, limit: number) {
	return api.get<Array<Question>>(
		`/questions/query?phrase=${phrase}&offset=${offset}&limit=${limit}`,
		{},
	);
}

export function postQuestion(body: string) {
	return api.post(
		"/questions",
		{
			"Content-Type": "application/json",
			Authorization: `Bearer ${jwt?.token}`,
		},
		JSON.stringify({ body }),
	);
}

export function updateQuestion(questionid: number, body: string) {
	return api.put(
		`/questions/${questionid}`,
		{
			"Content-Type": "application/json",
			Authorization: `Bearer ${jwt?.token}`,
		},
		JSON.stringify({ body }),
	);
}
