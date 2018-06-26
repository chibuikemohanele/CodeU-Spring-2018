// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.model.data;

import java.time.Instant;
import java.util.UUID;
import java.util.ArrayList;

/** Class representing a registered user. */
public class Feed {

  private ArrayList<String[]> myFeed;
  /**
   * Constructs a new Feed.
   */
  public Feed() {
    myFeed = new ArrayList<String[]>();
  }

  /** Document new registered user. */
  public void addNewUser(String date, String username) {
    // TODO
  }

  /** Document new conversation. */
  public void addNewConversation(String date, String username, String conversation) {
    // TODO
  }

  /** Document new message. */
  public void addNewMessage(String date, String username, String conversation, String message) {
    // TODO
  }

  /** Sort feed by time **/
  public void sortByTime() {
    // TODO
  }
}
