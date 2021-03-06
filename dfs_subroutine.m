function [runTime, clockTime, ISolutions] = dfs(node, maxDepth, GoalState)
    runTime = -1;
    clockTime = -1;
    ISolutions = [];
if (node.pathcost == maxDepth)
    %return failure to find

    return
end

for a = 1:4
    blank = find(node.state == 0);
    isViableAction = 1;
    childState = node.state;
    if(a == Actions.LEFT && blank ~= 1 && blank ~= 4 && blank ~= 7)
        childState = TakeAction(childState, a);
    elseif(a == Actions.RIGHT && blank ~= 3 && blank ~= 6 && blank ~= 9)
        childState = TakeAction(childState, a);
    elseif(a == Actions.UP && blank ~= 1 && blank ~= 2 && blank ~= 3)
        childState = TakeAction(childState, a);    
    elseif(a == Actions.DOWN && blank ~= 7 && blank ~= 8 && blank ~= 9)
        childState = TakeAction(childState, a);
    else
       isViableAction = 0;
    end
    if(isViableAction == 1)
        child = struct('state', childState, 'pathcost', node.pathcost + 1, 'parent', node);
       if(isequal(child.state, GoalState)) 
           %solution found
          runTime = child.pathcost;
          clockTime = toc;
                  traceNode = child;
                  solutionTrace = 1;
                  ISolutions{solutionTrace} = traceNode.state;
                  while(~isequal(traceNode.parent,0))
                      solutionTrace = solutionTrace + 1;
                      traceNode = traceNode.parent;
                      ISolutions{solutionTrace} = traceNode.state;
                  end
            return
       else
           %recursively search
           [runTime, clockTime, ISolutions] = dfs_subroutine(child, maxDepth, GoalState);
           if (runTime ~= -1)
               return
           end
        end
    end
end