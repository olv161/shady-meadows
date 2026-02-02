import com.intuit.karate.junit5.Karate;

class ShadyMeadowsTest {

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }
}