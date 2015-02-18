function [runTime, clockTime] = dfs(node, explored, maxDepth, GoalState)
    runTime = -1;
    clockTime = -1;
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
        child = struct('state', childState, 'pathcost', node.pathcost + 1);
        pathcost = 999999;
        for i = 1:explored.size();
            node2 = explored.Elements{i};
           if(isequal(child.state,node2.state )) 
               pathcost = node2.pathcost;
               break;
           end
        end
        if (pathcost ~= 999999 && child.pathcost < pathcost)
               explored.remove(node2);
        end
        if(child.pathcost < pathcost)
            
               explored.offer(child);
           if(isequal(child.state, GoalState)) 
               %solution found
              runTime = child.pathcost;
              clockTime = toc;
                return
           else
               %recursively search
               [runTime, clockTime] = dfs_subroutine(child, explored, maxDepth, GoalState);
               if (runTime ~= -1)
                   return
               end
           end
        end
    end
end