export class ApiError extends Error {
	status: number;

	constructor(status: number, message?: string) {
		super(message || "API request failed");
		this.name = "ApiError";
		this.status = status;
		Object.setPrototypeOf(this, ApiError.prototype);
	}
}

export class ValidationError extends Error {
	constructor(message?: string) {
		super(message || "Invalid input");
		this.name = "ValidationError";
		Object.setPrototypeOf(this, ApiError.prototype);
	}
}

export class Api {
	private baseUrl: string = "";

	constructor() {
		if (process.env.REACT_APP_API_URL)
			this.baseUrl = process.env.REACT_APP_API_URL;
	}

	private async handleResponse<T>(response: Response): Promise<T> {
		const data = await response.json().catch(() => ({}));
		if (!response.ok) {
			throw new ApiError(
				response.status,
				data.errors
					? Object.values(data.errors).join(", ")
					: data.message || "Unknown error",
			);
		}
		return data as T;
	}

	async get<T>(endpoint: string, headers: Record<string, string>): Promise<T> {
		const response = await fetch(`${this.baseUrl}${endpoint}`, {
			method: "GET",
			headers: headers,
		});
		return this.handleResponse<T>(response);
	}

	async post<T>(
		endpoint: string,
		headers: Record<string, string>,
		body: any,
	): Promise<T> {
		const response = await fetch(`${this.baseUrl}${endpoint}`, {
			method: "POST",
			headers: headers,
			body: body,
		});
		return this.handleResponse<T>(response);
	}

	async put<T>(
		endpoint: string,
		headers: Record<string, string>,
		body: any,
	): Promise<T> {
		const response = await fetch(`${this.baseUrl}${endpoint}`, {
			method: "PUT",
			headers: headers,
			body: body,
		});
		return this.handleResponse<T>(response);
	}
}
