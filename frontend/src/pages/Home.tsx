import React, { useState, useEffect } from "react";
import { getQuestions, Question, Answer } from "../services/questionService";
import { QuestionCard } from "../components/Cards/";

function GetComments(answer: Answer, depth: number) {
	if (!answer.answers || answer.answers.length == 0) {
		return <h1 style={{ textIndent: `${depth * 15}px` }}>{answer.body}</h1>;
	}

	return answer.answers.map((a) => (
		<h1 style={{ textIndent: `${depth * 15}px` }}>
			{GetComments(a, depth + 1)}
		</h1>
	));
}

function Home() {
	const [questions, setQuestions] = useState<Array<Question>>();

	useEffect(() => {
		async function load() {
			setQuestions(await getQuestions());
			console.log(await getQuestions());
		}
		load();
	}, []);

	return (
		<div className="App">
			<header className="App-header">Welcome Home!</header>
			{questions &&
				questions.map((q) => (
					<React.Fragment key={q.body}>
						<QuestionCard
							body={q.body}
							footer={`Asked by User ${q.user.username} (${q.user.email})`}
						/>

						{q.answers && q.answers.length > 0 && (
							<>{q.answers.map((a) => GetComments(a, 1))}</>
						)}
					</React.Fragment>
				))}
		</div>
	);
}

export default Home;
