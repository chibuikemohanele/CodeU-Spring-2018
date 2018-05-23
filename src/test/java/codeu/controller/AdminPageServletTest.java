package codeu.controller;

import codeu.model.data.User;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.time.Instant;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;

public class AdminPageServletTest {

  private ChatServlet adminServlet;
  private HttpServletRequest mockRequest;
  private HttpSession mockSession;
  private HttpServletResponse mockResponse;
  private RequestDispatcher mockRequestDispatcher;
  private ConversationStore mockConversationStore;
  private MessageStore mockMessageStore;
  private UserStore mockUserStore;

  @Before
  public void setup() {
    adminServlet = new AdminServlet();

    mockRequest = Mockito.mock(HttpServletRequest.class);
    mockSession = Mockito.mock(HttpSession.class);
    Mockito.when(mockRequest.getSession()).thenReturn(mockSession);

    mockResponse = Mockito.mock(HttpServletResponse.class);
    mockRequestDispatcher = Mockito.mock(RequestDispatcher.class);
    Mockito.when(mockRequest.getRequestDispatcher("/WEB-INF/view/admin.jsp"))
        .thenReturn(mockRequestDispatcher);

    mockConversationStore = Mockito.mock(ConversationStore.class);
    adminServlet.setConversationStore(mockConversationStore);

    mockMessageStore = Mockito.mock(MessageStore.class);
    adminServlet.setMessageStore(mockMessageStore);

    mockUserStore = Mockito.mock(UserStore.class);
    adminServlet.setUserStore(mockUserStore);
  }

  @Test
  public void testDoGet() throws IOException, ServletException {
    // creating fake conversation list for test with 6 conversations
    List<Conversation> fakeConversationList = new ArrayList<>();
    for (int i = 0; i < 6; i++) {
      UUID convoID = UUID.randomUUID();
      UUID owner = UUID.randomUUID();
      String title = "test_conversation_" + Integer.toString(i);
      Instant creation = Instant.now();
      fakeConversationList.add(new Conversation(convoID, onwer, title, creation));
      // creating fake messages list (count: 4) for test, for each conversation
          List<Message> fakeMessageList = new ArrayList<>();
          for (int i = 0; i < 4; i++) {
            UUID msgID = UUID.randomUUID();
            UUID author = UUID.randomUUID();
            String content = "fake message!! " + Integer.toString(i) + "for conversation " + Integer.toString(id);
            Instant creation = Instant.now();
            fakeMessageList.add(new Message(msgID, convoID, author, content, creation));
          }
          Mockito.when(mockMessageStore.getMessagesInConversation(convoID))
              .thenReturn(fakeMessageList);
    }
    Mockito.when(mockConversationStore.getAllConversations()).thenReturn(fakeConversationList);

    // creating fake users list for test with 3 users
    List<User> fakeUsersList = new ArrayList<>();
    for (int i = 0; i < 3; i++) {
      // User(UUID id, String name, String passwordHash, Instant creation)
      UUID userID = UUID.randomUUID();
      String name = "random_user_" + Integer.toString(i);
      String passwordHash = "hash" + Integer.toString(i);
      Instant creation = Instant.now();
      fakeUsersList.add(new User(userID, name, passwordHash, creation));
    }
    Mockito.when(mockUserStore.getAllUsers()).thenReturn(fakeUsersList);

    adminServlet.doGet(mockRequest, mockResponse);
    Mockito.verify(mockRequest).setAttribute("conversations", fakeConversationList);
    Mockito.verify(mockRequest).setAttribute("messages", fakeMessageList);
    Mockito.verify(mockRequest).setAttribute("users", fakeUsersList);
    Mockito.verify(mockRequestDispatcher).forward(mockRequest, mockResponse);
  }
}
