import { test } from '@playwright/test';
import { AdminLoginPage } from '../pages/auth.page';
import { AdminDashboardPage } from '../pages/admin.dashboard.page';

test.describe('Admin Login Page Check', () => {
    let adminLoginPage: AdminLoginPage;
    let adminDashboardPage: AdminDashboardPage;

    // this is test fixture that will run before each test in this describe block
    // can be extracted to fixture, but for simplicity keeping it here
    test.beforeEach(async ({ page }) => {
        adminLoginPage = new AdminLoginPage(page);
        adminDashboardPage = new AdminDashboardPage(page);
        await adminLoginPage.navigate();
    });

    test('Should display login form and all elements of login form', async () => {
        await adminLoginPage.assertLoginFormVisible();
    });

    test('Should login as admin with valid credentials', async ({ page }) => {
        // 1. Log in via the admin portal
        await adminLoginPage.loginAsAdmin();

        // 2. Assert that you are redirected to the Dashboard/Inboxes view
        await adminDashboardPage.assertIsLoaded();
        await adminDashboardPage.assertRedirectionToDashboard();

        // 3. Verify the presence of the "Logout" button - logout is on adminDashboardPage
        await adminDashboardPage.logoutButton.waitFor({ state: 'visible' });
        // @todo - logout visible on login page - bug
    });
});