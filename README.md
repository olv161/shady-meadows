# Shady Meadows B&B - Test Assessment

Test suite for [Shady Meadows B&B](https://automationintesting.online/) covering API and UI testing.

## Approach

- **API Tests (Karate DSL)**: Tests REST endpoints for booking, rooms, branding
- **UI Tests (Playwright)**: Page Object Model pattern for homepage and admin panel testing

*Note: Given time constraints, fixtures and utils were not created. In a real project, these would be extended for better test data management and reusability.*

### Running Tests

```bash
# API Tests
cd karate && mvn clean test

# UI Tests
cd playwright && npm install && npx playwright test
```

### Test Reports

**Karate**: Open `karate/target/karate-reports/karate-summary.html`

**Playwright**: Open `playwright/playwright-report/index.html` or run `npx playwright show-report`

## Bugs Found

1. **Logout button visible on login page** - logout button visible and actionable on the admin login page before user is authenticated
2. **Duplicate branding content** - `/branding/` API returns identical text for `description` and `directions` fields
3. **Dead amenities link** - Amenities header in navigation does not lead anywhere
4. **Invalid date selection** - Users can select a check-in date after check-out date when filtering rooms

## CI/CD Integration

Tests run automatically via GitHub Actions (`.github/workflows/test-run.yml`) on every pull request.

**Two parallel jobs:**
- **api-tests**: Runs Karate tests with Java 21, uploads reports as artifacts
- **ui-tests**: Runs Playwright tests with Node 18, uploads reports and test results as artifacts

## Test Results
API Tests (Karate)
<img width="1324" height="364" alt="image" src="https://github.com/user-attachments/assets/906fd3d5-3426-4c26-85d7-d75b8083453b" />

UI Tests (Playwright) - UI tests executed across Chromium, Firefox, and WebKit
<img width="1061" height="955" alt="image" src="https://github.com/user-attachments/assets/f758c5e3-8bf6-4c6b-babc-90c7bae2a97d" />
