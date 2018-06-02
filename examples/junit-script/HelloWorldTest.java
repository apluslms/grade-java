package apluslms;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;

public class HelloWorldTest {

    private HelloWorld h;

    @Before
    public void setUp() throws Exception {
        h = new HelloWorld();
    }

    @Test
    public void testNameHelloEmpty() {
        assertEquals("name is not empty", h.getName(),"");
    }

    @Test
    public void testNameHelloWorld() {
        h.setName("World");
        assertEquals("name is not 'World'", h.getName(),"World");
    }

    @Test
    public void testMessageHelloEmpty() {
        assertEquals("message is not 'Hello!'", h.getMessage(),"Hello!");
    }

    @Test
    public void testMessageHelloWorld() {
        h.setName("World");
        assertEquals("message is not 'Hello World!'", h.getMessage(),"Hello World!");
    }
}
