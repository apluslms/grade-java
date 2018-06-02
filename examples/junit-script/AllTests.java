import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import junit.framework.JUnit4TestAdapter;
import junit.framework.TestResult;

@RunWith(Suite.class)
@Suite.SuiteClasses({
   apluslms.HelloWorldTest.class
})

public class AllTests {
    public static void main(String[] args) {
       TestResult result = junit.textui.TestRunner.run(suite());
       int errors = result.errorCount() + result.failureCount();
       int max_points = result.runCount();
       System.out.println("MaxPoints: " + max_points);
       int points = max_points - errors;
       System.out.println("TotalPoints: " + points);
       System.exit(result.wasSuccessful() ? 0 : 1);
    }

    public static junit.framework.Test suite() {
       return new JUnit4TestAdapter(AllTests.class);
    }
}
