import React, { useState } from "react";
import { TextInput } from "../../Input";
import { SubmitButton } from "../../Buttons";
import { postQuestion } from "../../../services/questionService";

interface QuestionFormProps {
	afterSubmit?: () => void;
}
const QuestionForm: React.FC<QuestionFormProps> = ({ afterSubmit = null }) => {
	const [body, setBody] = useState("");
	const [error, setError] = useState("");

	async function onSubmit(e: React.FormEvent) {
		e.preventDefault();

		try {
			await postQuestion(body);
			if (afterSubmit) afterSubmit();
			setBody("");
			setError("");
		} catch (err: any) {
			setError(err.message);
		}
	}

	return (
		<>
			<form onSubmit={onSubmit}>
				<TextInput label="" type="text" value={body} onChange={setBody} />
				<SubmitButton label="Post question" />
			</form>
			{error && <p>{error}</p>}
		</>
	);
};

export default QuestionForm;
