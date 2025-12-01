import React, { useState, useEffect } from "react";

import { getAnswersToQuestion, Answer } from "../../../services/answerService";

interface AnswerCardProps {
	id: number;
	body: string;
	footer?: string;
}

const AnswerCard: React.FC<AnswerCardProps> = ({ id, body, footer }) => {
	const [showAnswer, setShowAnswer] = useState(false);
	const [answers, setAnswers] = useState<Array<Answer>>();

	useEffect(() => {
		async function load() {
			setAnswers(await getAnswersToQuestion(id));
		}
		load();
	}, [id]);

	const toggleAnswer = () => setShowAnswer((prev) => !prev);
	return (
		<div
			style={{
				border: "1px solid #ccc",
				borderRadius: "8px",
				padding: "16px",
				marginBottom: "12px",
				boxShadow: "0 2px 6px rgba(0,0,0,0.1)",
			}}
		>
			<p>{body}</p>
			{footer && <small style={{ color: "#666" }}>{footer}</small>}
			{answers?.length !== 0 && (
				<button onClick={toggleAnswer}>toggle answers</button>
			)}

			{showAnswer &&
				answers?.map((a) => (
					<>
						<AnswerCard
							id={a.id}
							body={a.body}
							footer={`Answered by ${a.user.username} (${a.user.email})`}
						/>
					</>
				))}
		</div>
	);
};
export default AnswerCard;
