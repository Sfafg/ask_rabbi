import React, { useState, useEffect } from "react";
import {
	getQuestions,
	searchQuestions,
	Question,
} from "../services/questionService";
import { QuestionCard } from "../components/Cards/";
import { SearchBar, QuestionForm } from "../components/Form/";
import { getRole } from "../services/authService";

function Home() {
	const [phrase, setPhrase] = useState("");
	const [questions, setQuestions] = useState<Array<Question>>();

	async function searchPhrase(phrase: string) {
		setPhrase(phrase);
		if (phrase.length !== 0) setQuestions(await searchQuestions(phrase, 0, 10));
		else setQuestions(await getQuestions(0, 10));
	}

	async function loadMore() {
		const c = questions ? questions.length : 0;
		var newQuestions = [];
		if (phrase.length !== 0)
			newQuestions = await searchQuestions(phrase, c, 10);
		else newQuestions = await getQuestions(c, 10);
		setQuestions(questions?.concat(newQuestions));
	}
	useEffect(() => {
		async function load() {
			setQuestions(await getQuestions(0, 10));
		}
		load();
	}, []);

	return (
		<>
			<SearchBar onSearch={searchPhrase} />
			{questions?.map((q) => (
				<QuestionCard
					key={q.id}
					id={q.id}
					userId={q.user.id}
					body={q.body}
					footer={`Asked by ${q.user.username} (${q.user.email})`}
				/>
			))}
			<button onClick={loadMore}>load more</button>
			{getRole() === "u" && <QuestionForm />}
		</>
	);
}

export default Home;
