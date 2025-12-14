import React, { useState } from "react";
import { TextInput, BoolInput, FileInput } from "../../Input";
import { SubmitButton } from "../../Buttons/";
import { getRole, register } from "../../../services/authService";
import { useNavigate } from "react-router-dom";

interface RegisterProps {
	setRole: (value: string) => void;
}

const RegisterForm: React.FC<RegisterProps> = ({ setRole }) => {
	const [email, setEmail] = useState("");
	const [username, setUsername] = useState("");
	const [password, setPassword] = useState("");
	const [certificate, setCertificate] = useState<File | null>(null);
	const [isRabbi, setIsRabbi] = useState(false);
	const [error, setError] = useState("");
	const navigate = useNavigate();

	async function onSubmit(e: React.FormEvent) {
		e.preventDefault();

		try {
			await register(email, username, password, isRabbi, certificate);
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
					label="Email"
					type="email"
					value={email}
					onChange={setEmail}
				/>
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
				<BoolInput
					label="Are you a rabbi"
					checked={isRabbi}
					onChange={setIsRabbi}
				/>
				{isRabbi && (
					<FileInput
						label="Certificate"
						accept="image/png, image/jpeg"
						onChange={setCertificate}
					/>
				)}
				<SubmitButton label="Register" />
			</form>
			{error && <p>{error}</p>}
		</>
	);
};

export default RegisterForm;
