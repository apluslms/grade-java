package apluslms;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;

public class HelloWorldTest1 {

    private HelloWorld h;

    @Before
    public void setUp() throws Exception {
        h = new HelloWorld();
    }

    @Test
    public void testHelloEmpty() {
        assertEquals("name is not empty", h.getName(),"");
    }

    @Test
    public void testHelloWorld() {
        h.setName("World");
        assertEquals("name is not 'World'", h.getName(),"World");
    }
}
