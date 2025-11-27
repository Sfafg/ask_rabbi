import React from "react";

interface QuestionCardProps {
	body: string;
	footer?: string;
}

const QuestionCard: React.FC<QuestionCardProps> = ({ body, footer }) => {
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
		</div>
	);
};
export default QuestionCard;
