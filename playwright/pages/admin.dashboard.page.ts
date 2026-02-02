import { Page, Locator, expect } from '@playwright/test';

export class AdminDashboardPage {
    readonly page: Page;
    readonly logoutButton: Locator;
    readonly roomsLink: Locator;
    readonly messagesLink: Locator;
    readonly roomListing: Locator;
    readonly createRoomButton: Locator;
    readonly roomNameField: Locator;

    constructor(page: Page) {
        this.page = page;
        this.logoutButton = page.getByRole('button', { name: 'Logout' });
        this.roomsLink = page.getByRole('link', { name: 'Rooms' });
        this.messagesLink = page.getByRole('link', { name: /Messages/ });
        this.roomListing = page.getByTestId('roomlisting');
        this.createRoomButton = page.locator('#createRoom');
        this.roomNameField = page.locator('#roomName');
    }

    async assertIsLoaded() {
        await expect(this.page).toHaveURL(/.*admin/);
        await expect(this.roomsLink).toBeVisible();
        await expect(this.logoutButton).toBeVisible();
        await expect(this.roomNameField).toBeVisible();
    }

    async assertRedirectionToDashboard() {
        // URL may be /admin or /admin/rooms depending on app state
        await expect(this.page).toHaveURL(/.*\/admin/);
        await expect(this.createRoomButton).toBeVisible();
    }

    async navigateToRooms() {
        await this.roomsLink.click();
    }

    async navigateToMessages() {
        await this.messagesLink.click();
    }

    async logout() {
        await this.logoutButton.click();
    }
}