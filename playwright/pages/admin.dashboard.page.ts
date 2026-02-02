import { Page, Locator, expect } from '@playwright/test';

export class AdminDashboardPage {
    readonly page: Page;
    readonly logoutButton: Locator;
    readonly roomsLink: Locator;
    readonly messagesLink: Locator;

    constructor(page: Page) {
        this.page = page;
        this.logoutButton = page.getByRole('button', { name: 'Logout' });
        this.roomsLink = page.getByRole('link', { name: 'Rooms' });
        this.messagesLink = page.getByRole('link', { name: /Messages/ });
    }

    async assertIsLoaded() {
        await expect(this.page).toHaveURL(/.*admin/);
        await expect(this.roomsLink).toBeVisible();
        await expect(this.messagesLink).toBeVisible();
        await expect(this.logoutButton).toBeVisible();
    }

    async assertRedirectionToDashboard() {
        // URL may be /admin or /admin/rooms depending on app state
        await expect(this.page).toHaveURL(/.*\/admin/);
    }
}