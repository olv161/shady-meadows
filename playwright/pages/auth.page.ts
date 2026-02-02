import { Page, Locator, expect } from '@playwright/test';

export class AdminLoginPage {
    readonly page: Page;

    // Login form
    readonly usernameInput: Locator;
    readonly passwordInput: Locator;
    readonly loginButton: Locator;

    // Navigation
    readonly frontPageLink: Locator;
    readonly logoutButton: Locator;

    constructor(page: Page) {
        this.page = page;

        // Login form
        this.usernameInput = page.getByLabel('Username');
        this.passwordInput = page.getByLabel('Password');
        this.loginButton = page.getByRole('button', { name: 'Login' });

        this.logoutButton = page.getByRole('button', { name: 'Logout' });
        this.frontPageLink = page.getByRole('link', { name: 'Front Page' });
    }

    async navigate() {
        await this.page.goto('/admin');
    }

    async login(username: string, password: string) {
        await this.usernameInput.fill(username);
        await this.passwordInput.fill(password);
        await this.loginButton.click();
        // Wait for navigation after login
        await this.page.waitForURL(/.*admin.*/, { timeout: 10000 });
    }

    async loginAsAdmin() {
        const username = process.env.ADMIN_USERNAME || 'admin';
        const password = process.env.ADMIN_PASSWORD || 'password';
        await this.login(username, password);
    }

    async assertLoginFormVisible() {
        await expect(this.usernameInput).toBeVisible();
        await expect(this.passwordInput).toBeVisible();
        await expect(this.loginButton).toBeVisible();
    }
}