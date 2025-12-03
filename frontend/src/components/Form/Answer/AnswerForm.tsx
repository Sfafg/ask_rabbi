import React, { useState } from "react";
import { TextInput } from "../../Input";
import { SubmitButton } from "../../Buttons";
import { useNavigate } from "react-router-dom";
import { login } from "../../../services/authService";

const AnswerForm: React.FC = () => {
	const [username, setUsername] = useState("");
	const [error, setError] = useState("");
	const navigate = useNavigate();

	async function onSubmit(e: React.FormEvent) {
		e.preventDefault();

		try {
			await postAnswer();
		} catch (err: any) {
			setError(err.message);
		}
	}

	return (
		<>
			<form onSubmit={onSubmit}>
				<TextInput
					label=""
					type="text"
					value={username}
					onChange={setUsername}
				/>
				<SubmitButton label="Post answer" />
			</form>
			{error && <p>{error}</p>}
		</>
	);
};

export default AnswerForm;
