import React, { useState } from "react";
import { TextInput } from "../../Input";
import { SubmitButton } from "../../Buttons";
import { updateAnswer } from "../../../services/answerService";

interface EditAnswerFormProps {
	answerId: number;
	afterSubmit?: (value: string) => void;
}
const AnswerForm: React.FC<EditAnswerFormProps> = ({
	answerId,
	afterSubmit = null,
}) => {
	const [body, setBody] = useState("");
	const [error, setError] = useState("");

	async function onSubmit(e: React.FormEvent) {
		e.preventDefault();

		try {
			await updateAnswer(answerId, body);
			if (afterSubmit) afterSubmit(body);
		} catch (err: any) {
			setError(err.message);
		}
	}

	return (
		<>
			<form onSubmit={onSubmit}>
				<TextInput label="" type="text" value={body} onChange={setBody} />
				<SubmitButton label="Update answer" />
			</form>
			{error && <p>{error}</p>}
		</>
	);
};

export default AnswerForm;
