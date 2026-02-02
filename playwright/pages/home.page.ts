import { Page, Locator, expect } from '@playwright/test';

export class HomePage {
    readonly page: Page;

    // Contact Form
    readonly nameInput: Locator;
    readonly emailInput: Locator;
    readonly phoneInput: Locator;
    readonly subjectInput: Locator;
    readonly messageInput: Locator;
    readonly submitButton: Locator;

    // Rooms
    readonly roomsSection: Locator;
    readonly bookNowButtons: Locator;

    constructor(page: Page) {
        this.page = page;

        // Contact Form
        this.nameInput = page.getByTestId('ContactName');
        this.emailInput = page.getByTestId('ContactEmail');
        this.phoneInput = page.getByTestId('ContactPhone');
        this.subjectInput = page.getByTestId('ContactSubject');
        this.messageInput = page.getByTestId('ContactDescription');
        this.submitButton = page.getByRole('button', { name: 'Submit' });

        // Rooms section
        this.roomsSection = page.locator('#rooms');
        this.bookNowButtons = this.roomsSection.getByRole('link', { name: /book now/i });
    }

    async navigate() {
        await this.page.goto('/');
    }

    async assertContactFormVisible() {
        await expect(this.nameInput).toBeVisible();
        await expect(this.emailInput).toBeVisible();
        await expect(this.phoneInput).toBeVisible();
        await expect(this.subjectInput).toBeVisible();
        await expect(this.messageInput).toBeVisible();
        await expect(this.submitButton).toBeVisible();
    }

    async assertBookNowButtonsPresent(expectedCount?: number) {
        if (expectedCount !== undefined) {
            await expect(this.bookNowButtons).toHaveCount(expectedCount);
        } else {
            // Assert at least one book now button exists
            await expect(this.bookNowButtons.first()).toBeVisible();
        }
    }
}