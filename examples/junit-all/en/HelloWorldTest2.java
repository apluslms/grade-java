package apluslms;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;

public class HelloWorldTest2 {

    private HelloWorld h;

    @Before
    public void setUp() throws Exception {
        h = new HelloWorld();
    }

    @Test
    public void testHelloEmpty() {
        assertEquals("message is not 'Hello!'", h.getMessage(),"Hello!");
    }

    @Test
    public void testHelloWorld() {
        h.setName("World");
        assertEquals("message is not 'Hello World!'", h.getMessage(),"Hello World!");
    }
}
