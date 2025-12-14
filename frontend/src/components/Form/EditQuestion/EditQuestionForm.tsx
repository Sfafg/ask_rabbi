import React, { useState } from "react";
import { TextInput } from "../../Input";
import { SubmitButton } from "../../Buttons";
import { updateQuestion } from "../../../services/questionService";

interface EditQuestionFormProps {
	id: number;
	afterSubmit?: (value: string) => void;
}
const EditQuestionForm: React.FC<EditQuestionFormProps> = ({
	id,
	afterSubmit = null,
}) => {
	const [body, setBody] = useState("");
	const [error, setError] = useState("");

	async function onSubmit(e: React.FormEvent) {
		e.preventDefault();

		try {
			await updateQuestion(id, body);
			if (afterSubmit) afterSubmit(body);
			setBody("");
		} catch (err: any) {
			setError(err.message);
		}
	}

	return (
		<>
			<form onSubmit={onSubmit}>
				<TextInput label="" type="text" value={body} onChange={setBody} />
				<SubmitButton label="Update question" />
			</form>
			{error && <p>{error}</p>}
		</>
	);
};

export default EditQuestionForm;
