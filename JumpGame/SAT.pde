//the separating axis test:
boolean SAT(PVector[] axes, PVector[] verticesA, PVector[] verticesB) {
  for (int i = 0; i < axes.length; i++) {
    //project each shape onto the current axis
    Projection a = project(verticesA, axes[i]);
    Projection b = project(verticesB, axes[i]);
    //compare projections: do they overlap?
    if (
         !(
            ( a.min < b.min && b.min < a.max ) 
            || 
            ( b.min < a.min && a.min < b.max ) 
          )
       ) 
    {
      return false;
    }
  }
  return true;
}
