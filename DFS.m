GoalState = [1, 2, 3, 4, 5, 6, 7, 8, 0];
RunningTimes = zeros(1, 100);
ClockTimes = zeros(1, 100);
IStates = cell(100, 1);
actionStepMax = 20;

ISolutions = cell(100, actionStepMax);

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
    tic;
    node = struct('state', IStates{j}, 'pathcost', 0, 'parent', 0);
    if(isequal(node.state, GoalState)) 
        RunningTimes(j) = node.pathcost;
    end
    %dfs subroutine
    runTime = 0;
    clockTime = 0;
    [runTime, clockTime, ISolutions{j}] = dfs_subroutine(node, actionStepMax, GoalState);
    RunningTimes(j) = runTime;
    ClockTimes(j) = clockTime;
end
%histogram(RunningTimes);
%Clear workspace before running each time
figure();
scatter(RunningTimes, ClockTimes);
xlabel('RunningTimes');
ylabel('ClockTimes');
mean = mean(RunningTimes)
variance = var(RunningTimes)
