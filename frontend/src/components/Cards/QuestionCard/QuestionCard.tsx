import React, { useState, useEffect } from "react";
import { getAnswersToQuestion, Answer } from "../../../services/answerService";
import { getRole } from "../../../services/authService";
import { AnswerCard } from "../";
import { AnswerForm } from "../../Form/";

interface QuestionCardProps {
	id: number;
	body: string;
	footer?: string;
}

const QuestionCard: React.FC<QuestionCardProps> = ({ id, body, footer }) => {
	const [showAnswer, setShowAnswer] = useState(false);
	const [showAnswerForm, setShowAnswerForm] = useState(false);
	const [answers, setAnswers] = useState<Array<Answer>>();

	async function loadAnswers() {
		setAnswers(await getAnswersToQuestion(id));
	}
	useEffect(() => {
		loadAnswers();
	}, [id]);

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
			<div>
				{answers?.length !== 0 && (
					<button onClick={() => setShowAnswer((prev) => !prev)}>
						toggle answers
					</button>
				)}
				{getRole() === "r" && (
					<button onClick={() => setShowAnswerForm((prev) => !prev)}>
						answer
					</button>
				)}
			</div>

			{showAnswerForm && (
				<>
					<AnswerForm
						questionId={id}
						afterSubmit={() => {
							setShowAnswerForm(false);
							loadAnswers();
						}}
					/>
				</>
			)}
			{showAnswer &&
				answers?.map((a) => (
					<>
						<AnswerCard
							id={a.id}
							userId={a.user.id}
							body={a.body}
							footer={`Answered by ${a.user.username} (${a.user.email})`}
						/>
					</>
				))}
		</div>
	);
};
export default QuestionCard;
