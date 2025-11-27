import { Api } from "./api";

const api = new Api();

export interface Question {
	id: number;
	userId: number;
	body: string;
	answers: any[];
}

export function getQuestions() {
	return api.get<Array<Question>>("/questions", {});
}
