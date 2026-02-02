import { test } from '@playwright/test';
import { HomePage } from '../pages/home.page';

test.describe('Homepage Check', () => {
    let homePage: HomePage;

    test.beforeEach(async ({ page }) => {
        homePage = new HomePage(page);
        await homePage.navigate();
    });

    test('Should display Contact form and all elements of Contact form', async () => {
        await homePage.assertContactFormVisible();
    });

    test('Should display Book Now buttons for rooms on the homepage', async () => {
        await homePage.assertBookNowButtonsPresent();
    });
});