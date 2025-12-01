import { Api } from "./api";

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

export function getQuestions() {
	return api.get<Array<Question>>("/questions", {});
}
