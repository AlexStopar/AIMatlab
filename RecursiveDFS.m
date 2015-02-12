function [ result ] = RecursiveDFS( node, limit, GoalState)
    %RECURSIVEDFS Summary of this function goes here
    %   Detailed explanation goes here
    result = -1;
    if(isequal(node.state, GoalState))
       result = node.pathcost; 
    elseif(limit == 0)
       result = -1;
    else
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
                result = RecursiveDFS(child, limit - 1, GoalState);
            end
            if (result > -1)
                break;
            end
       end
    end
    potato = 1;
end

