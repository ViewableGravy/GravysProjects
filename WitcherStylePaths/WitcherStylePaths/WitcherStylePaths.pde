QuadTree qt = new QuadTree(); //<>//

void setup() {
  size(600, 600);
  
  Node node1 = new Node(new PVector(50, 50), null, null);
  Node node2 = new Node(new PVector(100, 50), null, node1);
  Node node3 = new Node(new PVector(150, 50), null, node2);

  qt.Add(node1);
  qt.Add(node2);
  qt.Add(node3);
  
  Node test = new Node(new PVector(125, 50), null, null);
  node2.AddNode(test);

  println(node2.next.pos);
  
  
}

void draw() {
 
  Node temp = qt.Query(new PVector(mouseX,100));
 if (temp != null) {
   println(temp.pos.x); 
 }
 
}

//all nodes stored by location
class QuadTree {
  ArrayList<Node> nodes = new ArrayList<Node>();
  QuadTree() {
    
  }
  
  //should properly shuffle into quad tree (in correct arraylist);
  public void Add(Node node) {
   nodes.add(node); 
  }
  
  //should return the node that is the closest to the mouse.
  public Node Query(PVector pos) {
    //pretend query
    for (Node node : nodes) {
      if (node.pos.x < pos.x + 20 && node.pos.x > pos.x - 20) {
        return node;
      }
    }
    return null;
  }
  
}


class Node {
  PVector pos;
  Node next;
  Node previous;

  Node(PVector pos, Node next, Node previous) {
    this.pos = pos;
    if (next != null) {
      next.previous = this;
    } 
    if (previous != null) {
      previous.next = this;
    }
    this.next = next;
    this.previous = previous;
  }

  void SetNext(Node node) {
    this.next = node;
  }

  //repeats position check if goes (addNode to prev/next);
  void AddNode(Node other) {
    if (other.pos.x < this.pos.x) {
      if (previous != null) {
        if (other.pos.x > previous.pos.x) {
          previous.next = other;
          previous = other;
        } else 
          previous.AddNode(other);
      } else 
        previous = other;
    } else if ( other.pos.x > this.pos.x) {
      if (next != null) {
        if (other.pos.x < next.pos.x) {
          next.previous = other;
          next = other;
        } else
          next.AddNode(other);
      } else 
        next = other;
    }
  }
}
