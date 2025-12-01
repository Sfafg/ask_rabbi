import { Api } from "./api";

const api = new Api();

export interface User {
	username: string;
	email: string;
}

export interface Answer {
	body: string;
	user: User;
	answers: Answer[];
}

export interface Question {
	user: User;
	body: string;
	answers: Answer[];
}

export function getQuestions() {
	return api.get<Array<Question>>("/questions", {});
}
