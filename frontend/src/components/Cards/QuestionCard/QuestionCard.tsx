import React, { useState, useEffect } from "react";
import { getAnswersToQuestion, Answer } from "../../../services/answerService";
import { getRole, getId } from "../../../services/authService";
import { AnswerCard } from "../";
import { AnswerForm, EditQuestionForm } from "../../Form/";

interface QuestionCardProps {
	id: number;
	userId: number;
	body: string;
	footer?: string;
}

const QuestionCard: React.FC<QuestionCardProps> = ({
	id,
	userId,
	body,
	footer,
}) => {
	const [showAnswer, setShowAnswer] = useState(false);
	const [showAnswerForm, setShowAnswerForm] = useState(false);
	const [showEditQuestionForm, setShowEditQuestionForm] = useState(false);
	const [answers, setAnswers] = useState<Array<Answer>>();
	const [body_, setBody] = useState(body);

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
			<p>{body_}</p>
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

				{getId() == userId && (
					<button onClick={() => setShowEditQuestionForm((prev) => !prev)}>
						edit
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
					<React.Fragment key={a.id}>
						<AnswerCard
							id={a.id}
							userId={a.user.id}
							body={a.body}
							footer={`Answered by ${a.user.username} (${a.user.email})`}
						/>
					</React.Fragment>
				))}
			{showEditQuestionForm && (
				<>
					<EditQuestionForm
						id={id}
						afterSubmit={(value: string) => {
							setBody(value);
							setShowEditQuestionForm(false);
						}}
					/>
				</>
			)}
		</div>
	);
};
export default QuestionCard;
