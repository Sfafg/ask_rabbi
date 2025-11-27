import { Api, ValidationError } from "./api";

const api = new Api();

export function login(username: string, password: string) {
	if (username.length < 3 || username.length > 50 || password.length < 6) {
		throw new ValidationError("Invalid credentials");
	}

	return api.post<string>(
		"/users/login",
		{ "Content-Type": "application/json" },
		JSON.stringify({ username, password }),
	);
}

export function register(
	email: string,
	username: string,
	password: string,
	isRabbi: boolean,
	certificate: File | null,
) {
	if (username.length < 3) {
		throw new ValidationError("Username has to have at least 3 characters");
	}
	if (username.length > 50) {
		throw new ValidationError("Username can not be longer than 50");
	}
	if (password.length < 6) {
		throw new ValidationError("Password has to have at leat 6 characters");
	}
	if (isRabbi && !certificate) {
		throw new ValidationError(
			"You need to provide a certificate to register as rabbi",
		);
	}

	const form = new FormData();
	form.append("email", email);
	form.append("username", username);
	form.append("password", password);
	if (certificate) form.append("certificate", certificate);

	return api.post("/users/register", {}, form);
}
