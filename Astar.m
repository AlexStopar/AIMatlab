GoalState = [1, 2, 3, 4, 5, 6, 7, 8, 0];
RunningTimes = zeros(1, 100);
ClockTimes = zeros(1, 100);
IStates = cell(100, 1);
actionStepMax = 13;
for k = 1:100
    IStates{k} = GoalState;
    for n = 1:randi(actionStepMax)
        IStates{k} = TakeAction(IStates{k}, randi(Actions.DOWN));
    end
end
[IStates, idx, idx2] = uniquecell(IStates);
while length(IStates) < 100
   IStates{length(IStates) + 1} = [];
   IStates{length(IStates)} = GoalState;
   for n = 1:randi(actionStepMax)
        IStates{length(IStates)} = TakeAction(IStates{length(IStates)}, randi(Actions.DOWN));
   end
   [IStates, idx, idx2] = uniquecell(IStates);
end


for j = 1:100
    solutionFound = 0;
    tic;
    distance = ManhattenDistance(IStates{j});
    node = struct('state', IStates{j}, 'pathcost', 0, 'manhattenDistance', distance);
    if(isequal(node.state, GoalState)) 
        RunningTimes(j) = node.pathcost;
        solutionFound = 1;
    end
    frontier = PriorityQueue(false);
    frontier.insert(node.pathcost + node.manhattenDistance,node);
    explored = Queue('double');
    explored.offer(node.state);
    while (solutionFound == 0)
        [asdf,node] = frontier.pop();
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
                   distance = ManhattenDistance(childState);
                child = struct('state', childState, 'pathcost', node.pathcost + 1, 'manhattenDistance', distance);
                if(~explored.contains(child.state))
                   if(isequal(child.state, GoalState)) 
                      RunningTimes(j) = child.pathcost;
                      ClockTimes(j) = toc;
                      solutionFound = 1;
                   end
                   frontier.insert(child.pathcost + child.manhattenDistance, child);
                   explored.offer(childState);
                end
            end
        end
    end
    explored.clear();
end
histogram(RunningTimes);
mean = mean(RunningTimes)
variance = var(RunningTimes)