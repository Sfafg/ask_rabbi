import React, { useState, useEffect } from "react";

import { getRole, getId } from "../../../services/authService";
import {
	getAnswersToQuestion,
	getAnswersToAnswer,
	Answer,
} from "../../../services/answerService";
import { AnswerForm, EditAnswerForm } from "../../Form/";

interface AnswerCardProps {
	id: number;
	userId: number;
	body: string;
	footer?: string;
}

const AnswerCard: React.FC<AnswerCardProps> = ({
	id,
	userId,
	body,
	footer,
}) => {
	const [showAnswer, setShowAnswer] = useState(false);
	const [showAnswerForm, setShowAnswerForm] = useState(false);
	const [showEditAnswerForm, setShowEditAnswerForm] = useState(false);
	const [answers, setAnswers] = useState<Array<Answer>>();
	const [bodyS, setBody] = useState<string>(body);

	async function loadAnswers() {
		setAnswers(await getAnswersToAnswer(id));
	}

	useEffect(() => {
		loadAnswers();
	}, [id]);

	return (
		<div
			style={{
				borderRadius: "8px",
				padding: "10px",
				marginBottom: "8px",
				boxShadow: "0 2px 6px rgba(0,0,0,0.1)",
			}}
		>
			<p>{bodyS}</p>
			{footer && <small style={{ color: "#666" }}>{footer}</small>}
			<div>
				{answers?.length !== 0 && (
					<button onClick={() => setShowAnswer((prev) => !prev)}>
						toggle answers
					</button>
				)}
				{getRole() === "r" && getId() != userId && (
					<button onClick={() => setShowAnswerForm((prev) => !prev)}>
						answer
					</button>
				)}

				{getId() == userId && (
					<>
						<button onClick={() => setShowEditAnswerForm((prev) => !prev)}>
							edit answer
						</button>
					</>
				)}
			</div>
			{showEditAnswerForm && (
				<>
					<EditAnswerForm
						answerId={id}
						afterSubmit={(body_) => {
							setBody(body_);
							setShowEditAnswerForm(false);
						}}
					/>
				</>
			)}
			{showAnswerForm && (
				<>
					<AnswerForm
						answerId={id}
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
export default AnswerCard;
