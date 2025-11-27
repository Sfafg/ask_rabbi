import React, { useState, useEffect } from "react";
import { getQuestions, Question } from "../services/questionService";
import { QuestionCard } from "../components/Cards/";

function Home() {
	const [questions, setQuestions] = useState<Array<Question>>();

	useEffect(() => {
		async function load() {
			setQuestions(await getQuestions());
		}
		load();
	}, []);

	return (
		<div className="App">
			<header className="App-header">Welcome Home!</header>
			{questions &&
				questions.map((q) => {
					return (
						<QuestionCard body={q.body} footer={`Asked by User ${q.userId}`} />
					);
				})}
		</div>
	);
}

export default Home;
