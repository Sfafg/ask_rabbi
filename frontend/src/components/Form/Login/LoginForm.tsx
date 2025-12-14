import React, { useState } from "react";
import { TextInput } from "../../Input";
import { SubmitButton } from "../../Buttons/";
import { useNavigate } from "react-router-dom";
import { login, getRole } from "../../../services/authService";

interface LoginProps {
	setRole: (value: string) => void;
}

const LoginForm: React.FC<LoginProps> = ({ setRole }) => {
	const [username, setUsername] = useState("");
	const [password, setPassword] = useState("");
	const [error, setError] = useState("");
	const navigate = useNavigate();

	async function onSubmit(e: React.FormEvent) {
		e.preventDefault();

		try {
			await login(username, password);
			setRole(getRole());

			navigate("/");
		} catch (err: any) {
			setError(err.message);
		}
	}

	return (
		<>
			<form onSubmit={onSubmit}>
				<TextInput
					label="Username"
					type="text"
					value={username}
					onChange={setUsername}
				/>
				<TextInput
					label="Password"
					type="password"
					value={password}
					onChange={setPassword}
				/>
				<SubmitButton label="Login" />
			</form>
			{error && <p>{error}</p>}
		</>
	);
};

export default LoginForm;
